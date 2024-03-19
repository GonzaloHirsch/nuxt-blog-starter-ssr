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
</script>
