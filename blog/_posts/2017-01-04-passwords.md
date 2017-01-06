---
title: Passwords
date: 2017-01-04
layout: post
---

Happy New Year everybody! Like probably many of you, I traveled for the holiday, flying on my airline of choice, [JetBlue](http://www.jetblue.com/). They've always treated me well and this last trip was no exception: our return flight was delayed a few hours, so they bought everyone dinner and gave us a $75 voucher towards our next flight. Sweet!

What does this have to do with passwords? Well, to manage that voucher, they use [TravelBank](https://travelbank.com). Cool, never heard of them, whatever it takes to get that sweet discount. 

They helpfully emailed me confirmation of this new account, which stated that my password would be emailed to me in a separate message. Red flag #1. Whatever, I'll change it once I'm in.

I open the email containing my password to discover that it's not a randomly generated password, but instead it's the same password I use to log into my JetBlue TrueBlue account, which has credit card information stored. Red flag #2, and that's a biggie.

I immediately go to change my TrueBlue password. It simply asks for the new password (plus confirmation). So, I fire up 1Password and generate a [passphrase](http://xkcd.com/936/). The form happily accepts it, so I log out to test (always do this when you change a password, you're about to see why).

I cannot log into my account. "Wrong username or password." How can this be, as I just changed it? Like so many other account management, it actually does have rules governing passwords, even though the password change area under my profile settings stated none.

I click "forgot password" to get the password reset email with link to the form to create a new one (which I feel is what should have happened in the first place with the TravelBank account). Aha! Passwords cannot be more than 20 characters long, well below the passphrase I had generated. The original password change form not only didn't state this, but didn't complain that my chosen password didn't comply. Instead, it silently truncated my input.

I love JetBlue and will continue to do business with them, but they committed several sins regarding passwords and account security here, as many other companies do:

**No initial password set session for a new account**

I would have preferred this to either be managed directly in my TrueBlue account, but since that isn't the case, the next best thing would have been to allow me to create my own new password in a specially authenticated session.

**Emailed non-temporary plaintext passwords**

What if I used this password for other services as well, as [many people do](https://nakedsecurity.sophos.com/2013/04/23/users-same-password-most-websites/)? If I were security savvy, I would go and change them all. But then, I wouldn't have used the same password for all those services.

**Inconsistent display of password rules between password change and reset forms**

It would be very simple to have the same HTML bullet point list in the Profile -> Settings -> Change Password form as exists in the Password Reset form. Heck, this could even be a piece of shared code.

**Silent modification of chosen password in the input field**

Upsetting the user's expectations like this, especially with respect to security, just shouldn't be acceptable. A good UI should immediately present feedback regarding compliance and help the user discover and fix the error. It should never even allow the user the possibility to submit invalid input.
