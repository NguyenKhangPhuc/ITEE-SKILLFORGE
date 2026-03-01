import type { Config } from "tailwindcss";

const config: Config = {
    theme: {
        extend: {
            fontFamily: {
                mono: ["var(--font-mono)"],
            },
        },
    },
};

export default config;