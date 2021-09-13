import launchBrowser from "./utils/launchBrowser";

import test, { Test } from "tape";

const npmrdsViewUrl = "http://lor.availabs.org:8761/views/22/table";

const tableRowsSelector = "#comparative_fact > tbody > tr";

const LOGGER_ON = false;

const FIVE_MIN = 5 * 60 * 1000;

const log = LOGGER_ON ? (...args: any[]) => console.log(...args) : () => {};

test("make API request", async function (t: Test) {
  t.timeoutAfter(FIVE_MIN);
  try {
    log("creating browser");
    const browser = await launchBrowser();

    log("creating page");
    const page = await browser.newPage();

    page.setDefaultNavigationTimeout(0);

    log("goto view");
    await page.goto(npmrdsViewUrl);

    log("awaiting selector");
    await page.waitForSelector(tableRowsSelector, { timeout: FIVE_MIN });

    const numRows = await page.evaluate((rowsSelector: string) => {
      const rows = Array.from(
        // @ts-ignore
        document.querySelectorAll(rowsSelector)
      );

      return rows.length;
    }, tableRowsSelector);

    log("Num Rows:", numRows);

    log("closing browser");

    await browser.close();

    log("done");

    t.ok(numRows > 0, "NPMRDS table is empty");
  } catch (err) {
    t.error(err);
  }
});
