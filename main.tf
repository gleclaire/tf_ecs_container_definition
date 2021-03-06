# container definition template mapping
data "template_file" "container_definitions" {
  template = "${file("${path.module}/container_definition.json.tmpl")}"

  vars {
    image          = "${var.image}"
    container_name = "${var.name}"
    container_port = "${var.container_port}"
    cpu            = "${var.cpu}"
    mem            = "${var.memory}"

    container_env = "${
      join (
        format(",\n      "),
        null_resource._jsonencode_container_env.*.triggers.entries
      )
    }"

    labels = "${jsonencode(var.labels)}"

    mountpoint_sourceVolume  = "${lookup(var.mountpoint, "sourceVolume", "none")}"
    mountpoint_containerPath = "${lookup(var.mountpoint, "containerPath", "none")}"
    mountpoint_readOnly      = "${lookup(var.mountpoint, "readOnly", false)}"
  }

  depends_on = [
    "null_resource._jsonencode_container_env"
  ]
}

# Create a JSON snippet with the list of variables to be passed to
# the container definitions.
#
# It will use a null_resource to generate a list of JSON encoded
# name-value maps like {"name": "...", "value": "..."}, and then
# we join them in a data template file.
resource "null_resource" "_jsonencode_container_env" {
  triggers {
    entries = "${
      jsonencode(
        map(
          "name", element(keys(var.container_env), count.index),
          "value", element(values(var.container_env), count.index),
          )
      )
    }"
  }

  count = "${length(var.container_env)}"
}

