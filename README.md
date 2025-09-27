# Sematic versioning script
Simple bash scripts for sematic versioning.

## Usage
Call updater.sh with required version and mode parameters

## Modes
- MAJOR, increases major version
- MINOR, increases minor version
- PATCH, increases patch version
- SUFFIX, used if only suffix needs modifications

## Flags
Flags s and r cannot be used together
### Flag list
- s flag: requires input for new suffix
- r flag: removes suffix

## Examples
Some common use case examples

### Increase version
- bash updater.sh \[version] \[mode]

### Increase version and replace/remove suffix
- bash updater.sh \[version] \[mode] -s new_suffix
  - this will update the version and replace or add specified suffix
- bash updater.sh \[version] \[mode] -r
  - this till update the version and remove the suffix

### Just replace/remove suffix
- bash updater.sh \[version] SUFFIX -s new_suffix
  - this will only replace the suffix
- bash updater.sh \[version] SUFFIX -r
  - this will remove the suffix