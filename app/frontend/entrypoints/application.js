import axios from 'axios'

import Layout from '../components/_layout.svelte'

import { createInertiaApp } from '@inertiajs/inertia-svelte'
import { InertiaProgress } from '@inertiajs/progress'

import 'uno.css'
import './global.css'

const pages = import.meta.glob('../pages/**/*.svelte')

const csrfToken = document.querySelector('meta[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

InertiaProgress.init()

createInertiaApp({ 
  resolve: async name => {
    const page = await pages[`../pages/${name}.svelte`]()
    return Object.assign({layout: Layout}, page)
  },
  setup({ el, App, props }) {
    new App({ target: el, props })
  },
})
