# Shadow

`SilkShadow` provides `none`, `xs`, `sm`, `md`, `lg`, and `xl`. Each non-zero
token maps to a restrained multi-layer `ShadowConfig` rather than Material
elevation.

The library is flat by default. `SilkButton`, `SilkIconButton`, `SilkCard`,
`SilkImage`, and `SilkTabNavigation` use `SilkShadow.none` unless the caller
opts into a shadow.
