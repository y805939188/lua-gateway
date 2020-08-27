describe("Busted unit testing framework", function()
  describe("should be all work", function()
    it("prometheus labels should match", function()
      local prometheus = require("prometheus").init("metrics")
      local cached_label_names = prometheus:cached_label_names({"pas_namespace", "pas_pod", "pas_id", "pas_deployment", "http_code"})
      local cached_health_labels = prometheus:construct_labels(cached_label_names, {"default", "a", "b", "c", "0"})
      assert.are.equal(cached_health_labels, 'pas_namespace="default",pas_pod="a",pas_id="b",pas_deployment="c",http_code="0"')
    end)
  end)
end)