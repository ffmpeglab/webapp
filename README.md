# FFmpegLab Web App

**The IDE for video engineers — run entirely in your browser.**

FFmpegLab is a powerful, browser-based video editing environment that runs entirely on your device using WebAssembly. No uploads, no servers, no subscriptions — just FFmpeg in your browser.

- **Live preview** — see your edits as you make them
- **30+ video operations** — crop, trim, scale, filter, transition, and more
- **Visual filtergraph editor** — build complex pipelines without the command line
- **Real-time linting** — catch syntax errors before they fail
- **Privacy-first** — all processing happens locally, 0 bytes uploaded

---

## Table of Contents

- [Quick Start](#quick-start)
- [Deployment Options](#deployment-options)
  - [GitHub Pages](#github-pages)
  - [Self-Host with Docker](#self-host-with-docker)
- [Environment Variables](#environment-variables)
- [Development](#development)
- [Architecture](#architecture)
- [Contributing](#contributing)
- [License](#license)

---

## Quick Start

The fastest way to try FFmpegLab is to open it in your browser:

👉 **[webapp.ffmpeglab.com/webapp](https://webapp.ffmpeglab.com/webapp)**

No account, no download, no installation. Just open the link and start editing.

---

## Deployment Options

### GitHub Pages

Deploy your own FFmpegLab instance for free with GitHub Pages:

1. **Fork this repository** — click the Fork button at the top of this page.
2. **Enable GitHub Pages** — go to Settings → Pages, select the `main` branch and `/(root)` folder.
3. **Access your deployment** — your instance will be live at `https://yourusername.github.io/webapp`.

That's it. No build step required — the `webapp/` directory contains pre-built static files ready to serve.

### Self-Host with Docker

For teams that need full control — storage, rendering, and sync on your own infrastructure — FFmpegLab can be self-hosted with Docker Compose.

**Why self-host:**

- **Data sovereignty** — keep footage in a specific region or on-premise
- **No vendor lock-in** — projects live in your storage, in open formats
- **Cost control** — run on hardware you already own
- **Security** — place the whole system behind your VPN or firewall

**Minimal Docker Compose setup:**

```yaml
services:
  ffmpeglab:
    image: ffmpeglab/ide:main
    ports:
      - "8080:8080"
    environment:
      - FFMPEGLAB_HOST=http://localhost:8080/webapp/
      - FFMPEGLAB_API=http://localhost:3000
      - EVOLU_DB_HOST=http://localhost:4000
      - EVOLU_DB_NAME=ffmpeglab
      - PEXELS_API_HOST=https://pexels.starpy.me/
      - PUBLIC_HOST=https://localhost:8080/
      - SUPABASE_HOST=https://office.starpy.me
      - SUPABASE_ANON_KEY=123456789qwerty

  evolu:
    image: evoluhq/evolu:pr-5
    ports:
      - "4000:4000"
```

**Start the services:**

```bash
docker compose up -d
```

**View the logs:**

```bash
docker compose logs -f ffmpeglab
```

The client is offline-first — rendering and effects processing run locally in the browser via WebAssembly. The self-hosted backend handles project sync and storage, not raw footage processing. That keeps the server light and your media local.

**Putting it behind your domain:**

Front the container with a reverse proxy (Caddy, Nginx, or Traefik) for TLS and your own hostname:

```
edit.example.com {
    reverse_proxy localhost:8080
}
```

**Production checklist:**

- Back up the `./projects` volume on a schedule
- Pin the image to a version tag instead of `latest` for reproducible deploys
- Restrict access with your VPN, SSO proxy, or basic auth at the reverse proxy
- Audit the open-source code before deploying in regulated environments

---

## Environment Variables

FFmpegLab supports environment variables for configuration and parameterized workflows:

| Variable | Description |
|----------|-------------|
| `FFMPEGLAB_HOST` | Host URL for the webapp |
| `FFMPEGLAB_API` | Host URL for the ffmpeglab server |
| `EVOLU_DB_HOST` | Database host URL |
| `EVOLU_DB_NAME` | Database name |
| `PUBLIC_HOST` | Public-facing host URL |
| `SUPABASE_HOST` | Supabase API URL (if using Supabase) |
| `SUPABASE_ANON_KEY` | Supabase anonymous key |

**Parameterizing renders:**

Define variables to turn hard-coded commands into reusable templates:

```bash
export INPUT_FILE=/data/raw/video.mp4
export OUTPUT_RESOLUTION=1920x1080
export CRF_VALUE=18

ffmpeg -i ${INPUT_FILE} -c:v libx264 -crf ${CRF_VALUE} -s ${OUTPUT_RESOLUTION} ${OUTPUT_DIR}/$(basename ${INPUT_FILE})
```

---

## Development

### Prerequisites

- Node.js (latest LTS)
- npm or yarn

### Local Development

```bash
# Clone the repository
git clone https://github.com/ffmpeglab/webapp.git
cd webapp

# Install dependencies
npm install

# Start the development server
npm run dev
```

### Building for Production

```bash
npm run build
```

The built files will be in the `dist/` or `webapp/` directory.

---

## Architecture

FFmpegLab is built on a modern, privacy-first architecture:

- **Frontend**: React/TypeScript with a responsive, mobile-friendly UI
- **FFmpeg Engine**: FFmpeg.wasm — a WebAssembly port of FFmpeg that runs in the browser
- **Processing**: All video decoding, effects, cropping, and encoding runs locally — no server uploads
- **Storage**: OPFS (Origin Private File System) for local file storage
- **Sync**: Optional backend for project sync and collaboration (self-hostable)

**Why this matters:** Your footage never leaves your device. Everything happens in your browser.

---

## Features

- **30+ video operations** — trim, crop, scale, rotate, flip, compress, convert, extract audio, create GIFs
- **xfade transitions** — 30+ presets including fade, dissolve, wipe, slide, glitch, and more
- **filter_complex effects** — overlay, scale, pad, crop, color correction, chroma key
- **Audio processing** — mix, duck, normalize, extract, convert
- **Real-time preview** — see your edits as you make them
- **Visual filtergraph editor** — build complex pipelines without the command line
- **Linting & debugging** — catch syntax errors before they fail
- **Collaboration** — live cursor, comments, voice, timeline sharing (with backend)
- **Offline-first** — works without an internet connection (after initial load)
- **Privacy-first** — 0 bytes uploaded, all processing on your device

---

## Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository** — click the Fork button
2. **Create a feature branch** — `git checkout -b feature/amazing-feature`
3. **Make your changes** — add your improvements
4. **Submit a pull request** — describe what you changed and why

Please read our contributing guidelines before submitting.

---

## License

FFmpegLab is open source and available under the [MIT License](LICENSE).

---

## Links

- **Website**: [ffmpeglab.com](https://ffmpeglab.com)
- **Documentation**: [ffmpeglab.com/articles](https://ffmpeglab.com/articles)
- **GitHub**: [github.com/ffmpeglab](https://github.com/ffmpeglab)
- **Self-hosting guide**: [Self-Hosting with Docker](https://www.ffmpeglab.com/articles/self-hosted-video-editor-docker.html)

---

**Run the whole editing pipeline on your own infrastructure. Open source and offline-first. Free in your browser to start.**