This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.js`. The page auto-updates as you edit the file.

## Publish homepage responsiveness changes

On Windows with Git and PowerShell available, run this from the repository root:

```powershell
.\scripts\publish-responsive-change.ps1
```

The script verifies the `origin` push URL and refuses to run if there are staged changes. It stages only the homepage responsive stylesheet, this documentation, and the script itself, then commits and pushes the current branch. To use a different commit message, pass `-CommitMessage "Your message"`.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Netlify

Connect this repository to Netlify and deploy the site from the repository root. The included `netlify.toml` runs `npm run build`; Netlify detects Next.js and configures its Next.js adapter automatically.

Do not set a static publish directory or add a catch-all redirect to `index.html`. The Netlify adapter handles Next.js routes, `next/image`, and other supported framework features.

See the [Netlify Next.js deployment guide](https://docs.netlify.com/build/frameworks/framework-setup-guides/nextjs/overview/) for details.
