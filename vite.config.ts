import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import { svelte } from '@sveltejs/vite-plugin-svelte';
import Unocss from 'unocss/vite'
import presetIcons from '@unocss/preset-icons'
import { presetAttributify, presetUno } from 'unocss'
import importAssets from 'svelte-preprocess-import-assets'
import { extractorSvelte } from '@unocss/core'
export default defineConfig({
  resolve: {
    dedupe: ['axios']
  },
  plugins: [
    RubyPlugin(),
    Unocss({
      extractors: [extractorSvelte],
      presets: [
        
        presetAttributify({ /* preset options */}),
        presetUno(),
        presetIcons({
          extraProperties: {
            'display': 'inline-block',
            'vertical-align': 'middle',
            // ...
          },
        }),
      ],
      theme: {
        colors: {
          light: '#f9fafe'
        }
      }
    }),
    svelte({
      preprocess: [importAssets()],
      experimental: {
        prebundleSvelteLibraries: true
      }
    })
  ]
})
