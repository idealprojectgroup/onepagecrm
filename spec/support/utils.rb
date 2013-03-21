def a_get(path)
  a_request(:get, OnePageCRM::Default::URL + path)
end

def a_post(path)
  a_request(:post, OnePageCRM::Default::URL + path)
end

def a_put(path)
  a_request(:put, OnePageCRM::Default::URL + path)
end

def a_delete(path)
  a_request(:delete, OnePageCRM::Default::URL + path)
end

def stub_get(path)
  stub_request(:get, OnePageCRM::Default::URL + path)
end

def stub_post(path)
  stub_request(:post, OnePageCRM::Default::URL + path)
end

def stub_put(path)
  stub_request(:put, OnePageCRM::Default::URL + path)
end

def stub_delete(path)
  stub_request(:delete, OnePageCRM::Default::URL + path)
end

def fixture_path
  File.expand_path("../../fixtures", __FILE__)
end

def fixture(file)
  File.new([fixture_path, file].join('/'))
end