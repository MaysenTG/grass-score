import Fuse from "fuse.js";
import grassRules, { fuseOptions } from "grass-rules";

const fuse = new Fuse(grassRules, fuseOptions);

export default fuse;

// Optional helper: simple search wrapper
export function searchRules(query) {
  return fuse.search(query);
}
