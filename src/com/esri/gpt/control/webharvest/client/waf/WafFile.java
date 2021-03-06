/* See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * Esri Inc. licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.esri.gpt.control.webharvest.client.waf;

import com.esri.gpt.framework.resource.api.SourceUri;
import com.esri.gpt.framework.resource.common.CommonPublishable;
import com.esri.gpt.framework.resource.common.UrlUri;
import java.io.IOException;

/**
 * WAF file.
 */
class WafFile extends CommonPublishable {

private UrlUri uri;
private WafProxy proxy;

public WafFile(WafProxy proxy, String url) {
  this.proxy = proxy;
  this.uri = new UrlUri(url);
}

public SourceUri getSourceUri() {
  return uri;
}

public String getContent() throws IOException {
  return proxy.read(getSourceUri().asString());
}
}
