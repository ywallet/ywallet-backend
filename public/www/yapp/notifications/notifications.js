(function() {
    'use strict';

    angular
        .module('yapp.notifications')  
        .controller('Notifications', Notifications);

    Notifications.$inject = ['$scope', 'DSNotifications'];
    function Notifications($scope, DSNotifications)
    {

        DSNotifications.addNotification('type1', 'title1', 'description1');
        DSNotifications.addNotification('type2', 'title2', 'description2');
        DSNotifications.addNotification('type3', 'title3', 'description3');
        DSNotifications.addNotification('type4', 'title4', 'description4');
        DSNotifications.addNotification('type5', 'title5', 'description5');
        
        $scope.rmNotification = function(index) {
            DSNotifications.rmNotification(index);            
        }
    }

})();