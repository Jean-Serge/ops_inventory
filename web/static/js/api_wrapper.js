import axios from 'axios'

const request = axios.create({
  baseURL: '/api',
  headers: {
    'Content-type': 'application/json'
  }
})

const patchDroplets = () => (
  request
    .patch('/synchronize_droplets')
    .then(() => {})
    .catch(() => {})
)

export { patchDroplets }
