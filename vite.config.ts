import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { svelte } from '@sveltejs/vite-plugin-svelte';
import Unocss from 'unocss/vite'

export default defineConfig({
  resolve: {
    dedupe: ['axios']
  },
  plugins: [
    RubyPlugin(),
    Unocss({ /* options */ }),
    svelte({
      experimental: {
        prebundleSvelteLibraries: true
      }
    })
  ]
})
