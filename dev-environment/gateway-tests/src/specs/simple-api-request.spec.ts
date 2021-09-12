import axios from "axios";

import test, { Test } from "tape";

test("make API request", async function (t: Test) {
  const data = await axios.get(
    "http://127.0.0.1:3000/sources?id=7&source=7&selected=19&contributor_id=&librarian_id="
  );

  t.ok(data);
});
