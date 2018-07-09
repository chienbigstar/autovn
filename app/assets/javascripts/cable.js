// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);

//    if (getCookie("token") && getCookie("ip")) {
//     var channel = App.cable.subscriptions.create('RoomChannel', {
//       received: function(data) {
//         $.ajax({
//           url: '/login/destroy',
//           type: 'DELETE',
//           success: function(result) {
//             channel.unsubscribe();
//             window.location.href = '/?stopped=true';
//           },
//           error: function() {
//             window.location.href = '/?stopped=true';
//           }
//         });
//       },
//       disconnected: function() {
//       },
//       speak: function() {
//         this.perform('speak', {});
//       }
//     });
//   }


// function getCookie(name) {
//   var value = "; " + document.cookie;
//   var parts = value.split("; " + name + "=");
//   if (parts.length == 2) return parts.pop().split(";").shift();
// }
