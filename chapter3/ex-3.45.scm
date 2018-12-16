The problem is that when deposit on account is called it is already
under serialization because of serialized exchange.

This will cause deadlock.