<template>
  <div
    class="flex flex-col items-center justify-center text-center text-gray-900 max-w-screen-sm md:max-w-screen-sm xl:max-w-screen-lg mx-auto"
    style="height: 100vh"
  >
    <h1 class="mb-2">Welcome to the blog starter!</h1>
    <h2 class="text-gray-700 mb-8">(SSR Edition)</h2>
    <p class="text-center mx-auto max-w-lg mb-12">
      This blog starter lives on GitHub in this repo
      <a
        href="https://github.com/GonzaloHirsch/nuxt-blog-starter-ssr"
        target="_blank"
        class="underline hover:no-underline"
        rel="noopener noreferrer"
        >GonzaloHirsch/nuxt-blog-starter-ssr</a
      >. This site is fully powered by SSR (Server-Side Rendering). It is a
      proof of concept that you can run fully serverless SSR sites on Google
      Cloud Platform.
    </p>
    <p class="text-center mx-auto max-w-lg mb-12">
      To prove that this is running on a serverless instance, across time, the
      ID of this instance or revision might change.
      <ul>
        <li><strong>Revision</strong>: <em class="break-all">{{ revision }}</em></li>
        <li><strong>Instance ID</strong>: <em class="break-all">{{ instanceId }}</em></li>
      </ul>
    </p>
    <a href="/blog/">Read the blog!</a>
  </div>
</template>

<script setup>
const { data: revision } = await useFetch('/api/revision')
const { data: instanceId } = await useFetch('/api/instance')

// Set the meta
const title = `SSR Nuxt Blog Starter | Gonzalo Hirsch`;
const description =
  'A proof of concept SSR application for Nuxt 3 using serverless containers via Cloud Run.';
const image = 'img/blog/sample.webp';
const baseUrl = 'https://ssr.gonzalohirsch.com/';
const canonicalPath = `${baseUrl}`;
// Get the authors
const { data: authorData } = await useAsyncData('home', () =>
  queryContent('/authors').findOne()
);
const webpage = {
  '@context': 'https://schema.org',
  '@type': 'WebPage',
  name: title,
  url: canonicalPath,
  description: description,
  publisher: authorData.value['Gonzalo Hirsch'],
  license: 'http://creativecommons.org/licenses/by-nc-sa/3.0/us/deed.en_US'
};
useHead({
  title: title,
  meta: [
    // OG
    { name: 'description', content: description },
    { hid: 'og:title', property: 'og:title', content: title },
    { hid: 'og:url', property: 'og:url', content: canonicalPath },
    { hid: 'og:description', property: 'og:description', content: description },
    { hid: 'og:image', property: 'og:image', content: baseUrl + image },
    { hid: 'og:type', property: 'og:type', content: 'website' },
    { hid: 'og:image:type', property: 'og:image:type', content: 'image/webp' },
    { hid: 'og:image:width', property: 'og:image:width', content: '800' },
    { hid: 'og:image:height', property: 'og:image:height', content: '418' },
    {
      hid: 'og:image:alt',
      property: 'og:image:alt',
      content: 'Gonzalo Hirsch'
    },
    // Twitter
    {
      hid: 'twitter:card',
      name: 'twitter:card',
      content: 'summary_large_image'
    },
    { hid: 'twitter:site', name: 'twitter:site', content: '@GonzaloHirsch' },
    {
      hid: 'twitter:creator',
      name: 'twitter:creator',
      content: '@GonzaloHirsch'
    },
    { hid: 'twitter:title', name: 'twitter:title', content: title },
    { hid: 'twitter:url', name: 'twitter:url', content: canonicalPath },
    {
      hid: 'twitter:description',
      name: 'twitter:description',
      content: description
    },
    { hid: 'twitter:image', name: 'twitter:image', content: baseUrl + image },
    {
      hid: 'twitter:image:alt',
      name: 'twitter:image:alt',
      content: 'Gonzalo Hirsch'
    }
  ],
  link: [
    {
      hid: 'canonical',
      rel: 'canonical',
      href: canonicalPath
    }
  ],
  script: [
    {
      type: 'application/ld+json',
      children: JSON.stringify(webpage)
    }
  ]
});
</script>
