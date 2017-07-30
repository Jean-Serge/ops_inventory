import {
  patchDroplets
} from './api_wrapper'

// Event to synchronize droplets
const elts = document.getElementsByClassName('btn-sync-droplet')
Array
  .from(elts)
  .forEach(elt => elt.addEventListener('click', patchDroplets))
