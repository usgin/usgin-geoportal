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
package com.esri.gpt.server.assertion.handler;
import com.esri.gpt.server.assertion.components.AsnContext;
import com.esri.gpt.server.assertion.index.Assertion;

/**
 * Handles the disabling of an assertion.
 */
public class AsnDisableHandler extends AsnOperationHandler {
  
  /** constructors ============================================================ */
  
  /** Default constructor */
  public AsnDisableHandler() {}
  
  /** methods ================================================================= */
  
  /**
   * Handle a disable operation.
   * @param context the assertion operation context
   * @throws Exception if a processing exception occurs
   */
  public void handle(AsnContext context) throws Exception {
        
    // disable the assertion
    Assertion assertion = this.getIndexAdapter().loadAssertionById(context,true);
    context.getAuthorizer().authorizeDisable(context,assertion);
    if (assertion.getSystemPart().getEnabled()) {
      assertion.getSystemPart().setEnabled(false);
      this.getIndexAdapter().index(context,assertion);
    }
    context.getOperationResponse().generateOkResponse(context,null);
  }

}
