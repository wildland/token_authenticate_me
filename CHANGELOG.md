## [0.10.0] - 2018-04-05
### Changed
- `email` on `User` no longer downcased per [rfc5321](https://tools.ietf.org/rfc/rfc5321.txt).
If you need this for you application you can restore previous functionallity by adding the following code to your `User` model:
```rb
class MyUserModel
  # ...
  include TokenAuthenticateMe::Concerns::Models::Authenticatable
  before_save :downcase_email
  # ...
  protected
  # ...
  def downcase_email
    self.email = email.downcase
  end
  # ...
```
You will also need to removed the `unique: true` index on your model.

## 0.4.2 / 2015-09-08
* [BUGFIX] fixed bug #26.
