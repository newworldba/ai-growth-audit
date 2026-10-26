import { explainTask } from "@netsujo/agent-role-contracts";
import { createHash } from "node:crypto";

const bundle = {
  schema_version: "0.1",
  policy_version: "permission-drift-eval-v1",
  policy: {
    capabilities: ["filesystem.read", "filesystem.write.scoped", "review.perform", "shell.execute"],
    read_only_forbids: ["filesystem.write.scoped", "shell.execute"]
  },
  policy_version: "1.0.0",
  roles: [
    {
      contract: {
        id: "workflow-implementer",
        version: 1,
        scope: "repository",
        status: "active",
        aliases: [],
        mission: {
          objective: "Change repository content within its declared scope.",
          responsibilities: ["Make the requested scoped change."],
          out_of_scope: ["Review its own implementation."],
          success_criteria: ["The diff remains inside declared authority."]
        },
        contract: {
          required_inputs: ["scope"],
          optional_inputs: [],
          outputs: ["handoff"],
          output_schema: null,
          acceptance_criteria: ["The task remains inside declared authority."],
          escalation_conditions: ["Escalate when authority is insufficient."]
        },
        authority: {
          authority_mode: "write_scoped",
          capabilities: ["filesystem.read", "filesystem.write.scoped"],
          prohibited_capabilities: ["review.perform", "shell.execute"],
          allowed_write_scopes: ["src/**"],
          cannot: ["approve_own_implementation"],
          may_delegate_to: [],
          reports_to: null,
          independence_requirements: ["A different declared role reviews the implementation."]
        },
        knowledge: {
          required_knowledge: [],
          optional_knowledge: [],
          repository_context: [],
          data_classification: ["public"],
          retention_policy: "No runtime memory."
        },
        reasoning: { reasoning_tier: "standard", max_turn_class: "normal", requires_independent_context: false }
      },
      body: "# workflow-implementer"
    },
    {
      contract: {
        id: "workflow-reviewer",
        version: 1,
        scope: "repository",
        status: "active",
        aliases: [],
        mission: {
          objective: "Review repository content without changing it.",
          responsibilities: ["Read and verify content only."],
          out_of_scope: ["Runtime enforcement is not provided by this check."],
          success_criteria: ["Report evidence and unresolved items."]
        },
        contract: {
          required_inputs: ["scope"],
          optional_inputs: [],
          outputs: ["handoff"],
          output_schema: null,
          acceptance_criteria: ["The task remains within declared authority."],
          escalation_conditions: ["Escalate when authority or acceptance evidence is insufficient."]
        },
        authority: {
          authority_mode: "read_only",
          capabilities: ["filesystem.read", "review.perform"],
          prohibited_capabilities: ["filesystem.write.scoped", "shell.execute"],
          allowed_write_scopes: [],
          cannot: ["approve_own_implementation"],
          may_delegate_to: [],
          reports_to: null,
          independence_requirements: ["The reviewer is not the implementer."]
        },
        knowledge: {
          required_knowledge: [],
          optional_knowledge: [],
          repository_context: [],
          data_classification: ["public"],
          retention_policy: "No runtime memory."
        },
        reasoning: { reasoning_tier: "standard", max_turn_class: "normal", requires_independent_context: true }
      },
      body: "# workflow-reviewer"
    }
  ],
  knowledge: [],
  routes: [
    {
      task_type: "repository-review",
      accountable: "workflow-implementer",
      executors: ["workflow-implementer"],
      reviewers: ["workflow-reviewer"],
      require_human_approval: true
    }
  ]
};

const task = {
  schema_version: "0.1",
  id: "repository-review-drift-eval",
  type: "repository-review",
  objective: "Review a scoped repository change.",
  inputs: { scope: "src/example.mjs" },
  acceptance_criteria: ["The task stays inside declared authority."]
};

export { bundle, task, explainTask };

const readCapability = "filesystem.read";
const reviewCapability = "review.perform";
const shellCapability = "shell.execute";
const reviewer = bundle.roles[1].contract.authority;

function inventoryCase(name, inventory, source) {
  const arcResult = explainTask(JSON.stringify(bundle, null, 2), JSON.stringify(task, null, 2));
  if (!inventory) {
    return {
      case: name,
      source,
      arc_valid: arcResult.valid,
      arc_errors: arcResult.errors,
      arc_diagnostic_codes: arcResult.diagnostic_codes,
      inventory_present: false,
      drift_detected: null,
      conclusion: "UNKNOWN_NO_TRUSTED_INVENTORY"
    };
  }

  const missing = reviewer.capabilities.filter((capability) => !inventory.includes(capability));
  const extra = inventory.filter((capability) => !reviewer.capabilities.includes(capability));
  const drift_detected = missing.length > 0 || extra.length > 0;
  return {
    case: name,
    source,
    arc_valid: arcResult.valid,
    arc_diagnostic_codes: arcResult.diagnostic_codes,
    inventory_present: true,
    missing_declared_capabilities: missing,
    unexpected_effective_capabilities: extra,
    drift_detected,
    conclusion: drift_detected ? "ROLE_TO_RUNTIME_DRIFT" : "TRUSTED_INVENTORY_MATCHES_DECLARATION"
  };
}

const result = {
  evidence_class: "SYNTHETIC_DECLARATION_AND_HOST_INVENTORY_COMPARISON",
  arc_package: "@netsujo/agent-role-contracts",
  arc_version: "1.0.0",
  exact_arc_source_commit: "9f6771056c47de971202360952af6d41941f7625",
  bundle_sha256: createHash("sha256").update(JSON.stringify(bundle, null, 2)).digest("hex"),
  task_sha256: createHash("sha256").update(JSON.stringify(task, null, 2)).digest("hex"),
  reviewer_declared_capabilities: reviewer.capabilities,
  reviewer_prohibited_capabilities: reviewer.prohibited_capabilities,
  runtime_enforcement_observed: false,
  runtime_enforcement: "NOT_MEASURED",
  native_harness_controls: "NOT_MEASURED_IN_THIS_FIXTURE",
  cases: [
    inventoryCase("expected-pass", [readCapability, reviewCapability], "synthetic trusted host"),
    inventoryCase("expected-mismatch", [readCapability, reviewCapability, shellCapability], "synthetic trusted host"),
    inventoryCase("unknown", null, "absent or agent-asserted"),
    inventoryCase("repaired-pass", [readCapability, reviewCapability], "synthetic trusted host")
  ]
};

console.log(JSON.stringify(result, null, 2));
