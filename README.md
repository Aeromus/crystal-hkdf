# hkdf

A Crystal implementation of a HMAC-based Extract-and-Expand Key Derivation Function as defined [here](https://datatracker.ietf.org/doc/html/rfc5869)

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     hkdf:
       github: Aeromus/hkdf
   ```

2. Run `shards install`

## Usage

```crystal
require "hkdf"
```

Example Usage
```crystal
  Hkdf.hkdf(my_ikm, 32)
```

## Contributing

1. Fork it (<https://github.com/your-github-user/hkdf/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Andrew Knoblach](https://github.com/Aeromus) - creator and maintainer
- [Isaac Sloan](https://github.com/elorest)    - contributor 
