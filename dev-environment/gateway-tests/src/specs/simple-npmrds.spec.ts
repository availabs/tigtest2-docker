import launchBrowser from "./utils/launchBrowser";

import test, { Test } from "tape";

const npmrdsViewUrl =
  "http://localhost:3000/views/19/table?utf8=%E2%9C%93&year=2016&month=1&day_of_week=1&vehicle_class=0&direction=&commit=Filter";

const tableRowsSelector = "#speed_fact > tbody > tr";

const LOGGER_ON = false;

const FIVE_MIN = 5 * 60 * 1000;

const log = LOGGER_ON ? (...args: any[]) => console.log(...args) : () => {};

test("make API request", { timeout: FIVE_MIN }, async function (t: Test) {
  try {
    log("creating browser");
    const browser = await launchBrowser();

    log("creating page");
    const page = await browser.newPage();

    page.setDefaultNavigationTimeout(0);

    log("goto view");
    await page.goto(npmrdsViewUrl);

    log("awaiting selector");
    await page.waitForSelector(tableRowsSelector, { timeout: 50000 });

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
    console.error(err);
    t.ok(false);
  }
});
