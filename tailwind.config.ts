import type { Config } from "tailwindcss";
import typography from "@tailwindcss/typography";
const config: Config = {
    content: [
        "./app/**/*.{js,ts,jsx,tsx,mdx}",
        "./components/**/*.{js,ts,jsx,tsx,mdx}",
    ],
    theme: {
        extend: {
            fontFamily: {
                mono: ["var(--font-mono)"],
            },
            typography: {
                DEFAULT: {
                    css: {
                        maxWidth: '100%',
                    },
                },
            },
        },
    },
    plugins: [
        typography,
    ],
};

export default config;