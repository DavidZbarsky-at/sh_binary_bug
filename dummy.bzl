def _dummy_rule_impl(ctx):
    validation_output = ctx.actions.declare_file(ctx.attr.name + ".validation")

    ctx.actions.run(
        executable = ctx.executable._bin,
        outputs = [validation_output],
        arguments = [validation_output.path, "hello world"],
    )

    return [
        OutputGroupInfo(
            _validation = depset([validation_output]),
        ),
    ]

dummy_rule = rule(
    implementation = _dummy_rule_impl,
    attrs = {
        "_bin": attr.label(
            default = Label("//:bin"),
            cfg = "exec",
            executable = True,
        ),
    },
)
