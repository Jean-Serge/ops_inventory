import {
    patchDroplets
} from './api_wrapper'

// Event to synchronize droplets
document
    .getElementById('btn-sync-droplet')
    .addEventListener('click', patchDroplets)