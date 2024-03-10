export default function ({ path, query, hash }) {
  if (path === '/' || path.endsWith('/')) return;

  // Add the trailing slash at the end.
  const nextPath = path + '/';
  const nextRoute = { path: nextPath, query, hash };

  // 308 Permanent Redirect
  return navigateTo(nextRoute, { redirectCode: 308 });
}
