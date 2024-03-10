# Nuxt 3 Blog Starter (with SSR)

Look at the [Nuxt 3 documentation](https://nuxt.com/docs/getting-started/introduction) to learn more.

---

- [Setup](#setup)
- [Development Server](#development-server)
  - [Simulating a Production Server](#simulating-a-production-server)

---

## Setup

Make sure to install the dependencies:

```bash
# yarn
yarn install

# npm
npm install

# pnpm
pnpm install
```

## Development Server

Start the development server on `http://localhost:3000`

```bash
npm run dev
```

### Simulating a Production Server

You can simulate a production deployment by building the server and running it locally:

```bash
npm run build && node .output/server/index.mjs
```

You will find the server on `http://localhost:3000`.

## Docker Image

You can run the Docker image locally to test the production server by doing the following (being in the root of the repository):

```bash
docker build . -t ssrblog
docker run -d -p 3000:3000 ssrblog
```

You can visualize the application in `http://localhost:3000`, and if you inspect the network requests, you should see requests for each of the documents once you travel to specific URLs.
