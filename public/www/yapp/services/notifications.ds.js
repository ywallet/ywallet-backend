(function(){
	'use strict';

	angular
		.module('yapp.services')
		.factory('DSNotifications', DSNotifications);

	DSNotifications.$inject = ['$rootScope', 'DSCacheFactory'];
	function DSNotifications($rootScope, DSCacheFactory)
	{
		var cacheKey = 'Notifications';

		var service = {
			addNotification: addNotification,
			rmNotification: rmNotification,
			getNotifications: getNotifications
		}

		return service;

		function getCacheKey() {
			return cacheKey;
		}

		function getNotifications() {

			var result = [],
				notificationsCache = DSCacheFactory.get('staticCache'),
				notifications = notificationsCache.get(cacheKey);

			if( !$rootScope.notifications )
			{
				if( notifications ) {
					result = notifications;

					$rootScope.numNewNotifications = 0;
					result.forEach(function(notif) {
						if( notif.read == false )
							$rootScope.numNewNotifications++;
					});
				}
				
				$rootScope.notifications = result;
			}
			else
				result = $rootScope.notifications;

			return result;
		}
		
		function addNotification(type, title, description) {

			var notificationsCache = DSCacheFactory.get('staticCache'),
				notifications = getNotifications(),
				newNotification = {
					id: 1,
					type: type,
					title: title,
					description: description,
					timestamp: (new Date()).getTime(),
					read: false
				};

			if( notifications.length > 0 )
				newNotification.id = notifications[0].id + 1;
			else
				notifications = [];
			
			notifications.unshift(newNotification);

			notificationsCache.put(cacheKey, notifications);

			$rootScope.notifications = notifications;
			$rootScope.numNewNotifications++;
		}

		function rmNotification(index) {

			var result = [],
				notificationsCache = DSCacheFactory.get('staticCache'),
				notifications = getNotifications(),
				numDeleteNewNotifications = 0,
				id;

			if( notifications.length > 0 && $rootScope.notifications[index] )
			{
				id = $rootScope.notifications[index].id;
				notifications.forEach(function(notif) {
					if(notif.id != id)
						result.push(notif);
					else if( notif.read == false )
						numDeleteNewNotifications++;
				});

				notificationsCache.put(cacheKey, result);

				$rootScope.notifications.splice(index, 1);
				$rootScope.numNewNotifications -= numDeleteNewNotifications;
			}
		}
	}

})()