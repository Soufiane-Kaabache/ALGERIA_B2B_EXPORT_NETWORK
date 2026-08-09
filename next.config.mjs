/** @type {import('next').NextConfig} */
const nextConfig = {
  typescript: {
    // Si vous souhaitez ignorer les erreurs TypeScript lors du build
    ignoreBuildErrors: true,
  },
  eslint: {
    // Si vous souhaitez ignorer les erreurs ESLint lors du build
    ignoreDuringBuilds: true,
  },
};

export default nextConfig;