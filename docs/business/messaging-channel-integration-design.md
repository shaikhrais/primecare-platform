# SMS, WhatsApp and Telegram integration

Status: researched design; new channel task integrations are not deployed.
User scope: users request and independently confirm authorized tasks within their
messaging channel, without requiring an app screen for each task.

## Provider findings

- SMS and WhatsApp use Twilio Programmable Messaging. Validate inbound webhook
  signatures against the configured public URL and all submitted form fields.
  A valid provider signature authenticates delivery, not a PrimeCare account.
- WhatsApp requires sender onboarding and recipient opt-in. Free-form messages
  use the customer-service window; outside it use an approved applicable template.
  A voice-enabled number is not automatically a WhatsApp-enabled sender.
- Telegram requires a bot. Validate X-Telegram-Bot-Api-Secret-Token, bind the bot,
  numeric user ID and private chat ID, and durably deduplicate update_id. Never
  use a mutable username as account identity. Restrict account tasks to private
  chats. Bot tokens remain server secrets; do not log token-bearing API URLs.
- Telegram callback_data is limited to 1–64 bytes. Use an opaque reference to a
  server-held confirmation, not a serialized task or an authorization token.

Sources reviewed:
https://www.twilio.com/docs/whatsapp/api
https://www.twilio.com/docs/messaging/guides/webhook-request
https://core.telegram.org/bots/api#setwebhook
https://core.telegram.org/bots/api#inlinekeyboardbutton

## Shared implementation

Extend CommunicationChannelBase for channel dispatch and ScopedServiceBase for
account linking and task services. Reuse existing Twilio SMS transport where its
registered sender/channel checks permit it; do not remove SMS-only checks to
silently accept WhatsApp. Telegram gets its own bounded provider adapter.

Resolve a current verified channel link to user and tenant server-side. First-time
linking needs an independent account verification ceremony; an SMS code entered
in the same SMS thread does not prove a second factor. Receiving a Telegram contact
or a WhatsApp phone number alone does not establish PrimeCare account ownership.
Shared phones need explicit account authorization, not automatic selection.

For a linked account, propose the task through shared policy, return its exact
server summary and a short-lived confirmation reference. SMS replies must contain
the unique proposal reference; a bare YES or 1 cannot choose among pending tasks.
WhatsApp buttons and Telegram callbacks bind the originating provider identity,
conversation, proposal digest, expiry and single-use challenge. Revalidate account,
contact/link version, tenant and resource permissions at approval and execution.
Deduplicate provider events and execution independently. Do not retry uncertain
writes or report success before result readback. Keep OTPs outside model input.

Media requires existing bounded download/type validation and private storage;
provider attachment URLs are untrusted inputs, not arbitrary-fetch authority.

## Next implementation gates

Inventory pinned production messaging contracts, then register missing webhook,
linking and confirmation contracts before mounting handlers. Add channel-link and
confirmation persistence with expiry/revocation and rollback tests. Test forged
webhooks, duplicate delivery, cross-user/chat/tenant callbacks, old proposal
replies, opt-out, WhatsApp window/template selection and uncertain delivery.
Verify provider configuration read-only before requesting any missing setup.
No messages sent, bots provisioned, sender registrations or routing changed by
this research step. Existing app-native voice endpoints are not messaging APIs.
