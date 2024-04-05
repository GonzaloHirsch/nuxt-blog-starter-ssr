<template>
  <div class="pagination-list text-typography_primary">
    <!-- Chevron -->
    <a
      v-if="currentPage > 1"
      class="pagination-item pagination-icon"
      :href="prevLink"
      ><IconsChevronDown
        class="transform rotate-90 h-6 w-6"
        width="24"
        height="24"
    /></a>
    <!-- First Page -->
    <a
      :class="['pagination-item', currentPage === 1 ? 'active' : '']"
      :href="baseUrl"
      >1</a
    >
    <!-- ... -->
    <span v-if="currentPage > 2" class="pagination-extra"> ... </span>
    <template v-for="page in pageRange" :key="page">
      <a
        v-if="page !== 1 && page !== totalPages"
        :class="['pagination-item', currentPage === page ? 'active' : '']"
        :href="getPageUrl(page)"
        >{{ page }}</a
      >
    </template>
    <!-- ... -->
    <span v-if="currentPage < totalPages - 1" class="pagination-extra">
      ...
    </span>

    <!-- Last Page -->
    <a
      v-if="totalPages > 1"
      :class="['pagination-item', currentPage === totalPages ? 'active' : '']"
      :href="getPageUrl(totalPages)"
      >{{ totalPages }}</a
    >
    <!-- Chevron -->
    <a
      v-if="currentPage < totalPages"
      class="pagination-item pagination-icon"
      :href="getPageUrl(currentPage + 1)"
      ><IconsChevronDown
        class="transform -rotate-90 h-6 w-6"
        width="24"
        height="24"
    /></a>
  </div>
</template>

<script setup>
import { computed } from 'vue';
const props = defineProps({
  currentPage: {
    type: Number,
    required: true
  },
  totalPages: {
    type: Number,
    required: true
  },
  nextPage: {
    type: Boolean,
    required: true
  },
  baseUrl: {
    type: String,
    required: true
  },
  pageUrl: {
    type: String,
    required: true
  }
});

const getPageUrl = (pageNo) => {
  return `${props.pageUrl}${pageNo}/`;
};
// Calculate the page range to show
const pageRange = [
  Math.max(1, props.currentPage - 1),
  props.currentPage,
  Math.min(props.totalPages, props.currentPage + 1)
];

const prevLink = computed(() => {
  return props.currentPage === 2
    ? props.baseUrl
    : `${props.pageUrl}${props.currentPage - 1}/`;
});
</script>

<style scoped>
.pagination-list {
  @apply flex flex-row w-full items-center justify-center;
}
.pagination-item.active {
  @apply bg-brand_primary text-background;
}
.pagination-item {
  @apply rounded-md border border-typography_primary px-2 py-1 mx-1 w-8 text-center h-full;
}
.pagination-item:not(.active):hover {
  @apply bg-brand_primary/25;
}
.pagination-extra {
  @apply w-8 text-lg leading-lg text-center;
}
.pagination-icon {
  @apply w-10 text-center;
}
</style>
