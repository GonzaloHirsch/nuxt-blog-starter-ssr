export default defineNuxtConfig({
  modules: ['@nuxtjs/tailwindcss', '@nuxt/content'],
  css: ['/assets/css/main.css'],
  ssr: true,
  nitro: {
    prerender: {
      routes: ['/sitemap.xml']
    }
  },
  experimental: {
    payloadExtraction: false,
    renderJsonPayloads: true
  },
  router: {
    options: {
      strict: false
    }
  },
  sourcemap: false,
  content: {
    // https://content.nuxtjs.org/api/configuration
    highlight: {
      theme: 'github-dark',
      preload: ['java', 'javascript']
    },
    markdown: {
      // https://github.com/rehypejs/rehype-external-links
      rehypePlugins: [
        [
          'rehype-external-links',
          {
            target: '_blank',
            rel: 'noopener noreferer'
          }
        ]
      ]
    }
  }
});
