// Generated from pinned production read-back, registration run 39850982551.
// Routing only: no role grants or live feature acceptance.
import 'dio_communication_transport.dart';

final registeredCommunicationBindings = Map<String, CommunicationRouteBinding>.unmodifiable({
  'message.create': CommunicationRouteBinding(path: '/v1/messages', method: 'POST'), // API710
  'message.send': CommunicationRouteBinding(path: '/v1/messages', method: 'POST'), // API710
  'message.mark_read': CommunicationRouteBinding(path: '/v1/messages', method: 'POST'), // API710
  'message.read': CommunicationRouteBinding(path: '/v1/messages', method: 'POST'), // API710
  'message.inbox': CommunicationRouteBinding(path: '/v1/messages/inbox', method: 'GET', includeAction: false), // API857
  'picture.upload': CommunicationRouteBinding(path: '/v1/messages/pictures', method: 'POST'), // API16508
  'picture.open': CommunicationRouteBinding(path: '/v1/messages/pictures', method: 'GET'), // API16509
  'audio.invite': CommunicationRouteBinding(path: '/v1/messages/calls', method: 'POST'), // API16510
  'audio.accept': CommunicationRouteBinding(path: '/v1/messages/calls', method: 'POST'), // API16510
  'audio.decline': CommunicationRouteBinding(path: '/v1/messages/calls', method: 'POST'), // API16510
  'audio.end': CommunicationRouteBinding(path: '/v1/messages/calls', method: 'POST'), // API16510
  'audio.expire': CommunicationRouteBinding(path: '/v1/messages/calls', method: 'POST'), // API16510
  'audio.signal': CommunicationRouteBinding(path: '/v1/messages/calls', method: 'POST'), // API16510
  'email.queue': CommunicationRouteBinding(path: '/v1/messages/email', method: 'POST'), // API16511
  'email.deliver': CommunicationRouteBinding(path: '/v1/messages/email', method: 'POST'), // API16511
  'email.read': CommunicationRouteBinding(path: '/v1/messages/email', method: 'POST'), // API16511
  'email.inbox': CommunicationRouteBinding(path: '/v1/messages/email/inbox', method: 'GET', includeAction: false), // API16512
});
