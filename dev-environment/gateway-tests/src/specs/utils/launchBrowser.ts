import puppeteer from "puppeteer";

// https://github.com/puppeteer/puppeteer/issues/6258#issuecomment-760240701
// https://github.com/alixaxel/chrome-aws-lambda/blob/1395ee60ad1625d08306a4aad8b7b851b73a9a83/source/index.js#L84-L122
// https://github.com/alixaxel/chrome-aws-lambda/issues/104

export default async function launchBrowser() {
  const browser = await puppeteer.launch({
    pipe: true,
    headless: true,
    ignoreHTTPSErrors: true,
    args: [
      "--no-sandbox",
      "--disable-dev-profile",
      "--user-data-dir=/dev/null",
      "--autoplay-policy=user-gesture-required",
      "--disable-background-networking",
      "--disable-background-timer-throttling",
      "--disable-backgrounding-occluded-windows",
      "--disable-breakpad",
      "--disable-client-side-phishing-detection",
      "--disable-component-update",
      "--disable-default-apps",
      "--disable-dev-shm-usage",
      "--disable-domain-reliability",
      "--disable-extensions",
      "--disable-features=AudioServiceOutOfProcess",
      "--disable-features=AudioServiceOutOfProcessKillAtHang",
      "--disable-software-rasterizer",
      "--disable-hang-monitor",
      "--disable-ipc-flooding-protection",
      "--disable-notifications",
      "--disable-offer-store-unmasked-wallet-cards",
      "--disable-popup-blocking",
      "--disable-print-preview",
      "--disable-prompt-on-repost",
      "--disable-renderer-backgrounding",
      "--disable-setuid-sandbox",
      "--disable-speech-api",
      "--disable-sync",
      "--disk-cache-size=33554432",
      "--hide-scrollbars",
      "--ignore-gpu-blacklist",
      "--disable-gpu",
      "--metrics-recording-only",
      "--mute-audio",
      "--no-default-browser-check",
      "--no-first-run",
      "--no-pings",
      "--no-sandbox",
      "--no-zygote",
      "--password-store=basic",
      "--use-gl=swiftshader",
      "--use-mock-keychain",
    ],
  });

  return browser;
}
