import { Controller } from "@hotwired/stimulus"
import Fuse from "fuse.js"
import grassRules from "grass-rules"
import localFuse from "fuse-index"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.modal = null
    this._pendingQuery = null
    this.debounced = null
    this._boundInputHandler = (e) => {
      clearTimeout(this.debounced)
      const q = e.target.value.trim()
      if (q.length === 0) { this.resultsTarget.innerHTML = ''; return }
      this.debounced = setTimeout(() => this.search(q), 300)
    }

    if (this.hasInputTarget) {
      this.inputTarget.addEventListener('input', this._boundInputHandler)
    }

    this.rules = Array.isArray(grassRules) ? grassRules : []
    this.fuse = localFuse || null
    console.debug('rules_search: initial bundled rules', this.rules.length)
    if (this.rules.length > 0) {
      const sample = this.rules[0]
      console.debug('rules_search: sample rule keys', Object.keys(sample))
      console.debug('rules_search: sample rule id/title', sample.id, sample.title)
    }
    console.debug('rules_search: using imported localFuse?', !!localFuse)

    // Keep rule search entirely in the browser using the bundled static rules.
    const options = {
      keys: ['title', 'content', 'text', 'keywords'],
      threshold: 0.32,
      includeScore: true,
      includeMatches: true,
      ignoreLocation: true
    }
    try {
      this.fuse = new Fuse(this.rules, options)
    } catch (err) {
      console.error('rules_search: failed to create Fuse index', err)
    }
  }

  open(event) {
    event.preventDefault()
    const el = document.getElementById('rulesSearchModal')
    if (!this.modal) {
      if (window.bootstrap && window.bootstrap.Modal) {
        this.modal = new window.bootstrap.Modal(el)
      } else {
        el.classList.add('show')
        el.style.display = 'block'
        el.removeAttribute('aria-hidden')
      }
    }
    if (this.modal && this.modal.show) this.modal.show()

    // If Bootstrap modal is present, wait for its shown event to focus
    // and populate the input. Otherwise, fallback to a short timeout.
    if (window.bootstrap && el) {
      const shownHandler = () => {
        if (this.hasInputTarget) {
          if (this._pendingQuery) {
            this.inputTarget.value = this._pendingQuery
            if (this._pendingQuery.length > 0) this.search(this._pendingQuery)
            this._pendingQuery = null
          }
          this.inputTarget.focus()
        }
        if (this.hasResultsTarget && !this._pendingQuery) this.resultsTarget.innerHTML = ''
        el.removeEventListener('shown.bs.modal', shownHandler)
      }
      el.addEventListener('shown.bs.modal', shownHandler)
    } else {
      setTimeout(() => {
        if (this.hasInputTarget) {
          if (this._pendingQuery) {
            this.inputTarget.value = this._pendingQuery
            if (this._pendingQuery.length > 0) this.search(this._pendingQuery)
            this._pendingQuery = null
          }
          this.inputTarget.focus()
        }
        if (this.hasResultsTarget && !this._pendingQuery) this.resultsTarget.innerHTML = ''
      }, 150)
    }
  }

  disconnect() {
    if (this.hasInputTarget && this._boundInputHandler) {
      this.inputTarget.removeEventListener('input', this._boundInputHandler)
    }
  }

  openWithQuery(event) {
    // Open the modal and pre-fill with the provided query (from an input
    // or a button with data-query). This lets the homepage input hand off
    // a search term to the modal-based search UI.
    event.preventDefault()
    let query = ''
    const el = event.currentTarget || event.target
    if (el && el.dataset && el.dataset.query) query = el.dataset.query
    else if (el && typeof el.value === 'string') query = el.value.trim()
    else if (event && event.target && typeof event.target.value === 'string') query = event.target.value.trim()

    // Store pending query and open modal
    this._pendingQuery = query
    try {
      this.open(event)
    } catch (err) {
      console.error('rules_search: failed to open modal', err)
    }
    // The modal's shown handler will read `this._pendingQuery` and populate
    // the input and run the search when appropriate.
  }

  async search(q) {
    try {
      if (!this.fuse) {
        this.resultsTarget.innerHTML = '<div class="alert alert-info">Loading rules, please wait…</div>'
        return
      }

      const results = this.fuse.search(q)
      console.debug('rules_search: query', q, '=> results', results.length)
      this.resultsTarget.innerHTML = this._renderResults(results)
      return
    } catch (err) {
      this.resultsTarget.innerHTML = `<div class="alert alert-danger">Search failed: ${err.message}</div>`
    }
  }

  _renderResults(results) {
    if (!results || results.length === 0) return '<div class="alert alert-info">No rules found</div>'

    return results.map(res => {
      const r = res.item || res
      const raw = (r.text || r.content || '')
      const titleHtml = escapeHtml(r.title || '')
      const categoryHtml = escapeHtml(r.category || '')
      const contentHtml = escapeHtml(raw).replace(/\n/g, '<br/>')

      return `
        <div class="card mb-3">
          <div class="card-body">
            <h5 class="card-title">${titleHtml}</h5>
            <h6 class="card-subtitle mb-2 text-muted">${categoryHtml}</h6>
            <p class="card-text">${contentHtml}</p>
          </div>
        </div>
      `
    }).join('')
  }

}
function escapeHtml(str) {
  return (str || '').replace(/[&<>\"]/g, s => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;'}[s]))
}

