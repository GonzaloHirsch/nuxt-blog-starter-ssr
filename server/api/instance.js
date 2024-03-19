export default defineEventHandler((event) => {
  return fetch(
    'http://metadata.google.internal/computeMetadata/v1/instance/id',
    {
      headers: {
        'Metadata-Flavor': 'Google'
      }
    }
  ).then((response) => {
    return response.text();
  });
});
