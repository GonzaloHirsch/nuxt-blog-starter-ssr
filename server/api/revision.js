export default defineEventHandler((event) => {
  return process?.env?.K_REVISION || 'Not Found (env not available)';
});
