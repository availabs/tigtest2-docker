import axios from "axios";

import test, { Test } from "tape";

test("make API request", async function (t: Test) {
  const { data } = await axios.get(
    "https://api.github.com/repos/availabs/tigtest2-docker"
  );

  const { name } = data;

  t.ok(name === "tigtest2-docker");
});
