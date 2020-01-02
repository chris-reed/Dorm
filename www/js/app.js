$(function () {
    // build out the menu first so we can determine our default data.
    buildMenuItems();
});

/* ******************* main functions ******************* */

// requests data from server and builds the building selection menu
function buildMenuItems() {
    // AJAX call
    getData({
            route: 'Dormitory@getAll',
        },
        buildMenuItemsCallback
    );
}

// populates the building overview container
function floorView(building) {
    $('.building_name').text(building.name);
    $(`#building_${building.id}`).first().addClass('active');
    getFloorInfo(building.id);
}

// retrieves the occupancy info on the first floor of the default building
function getFloorInfo(building, floor = 1) {
    getData({
        route: 'RoomAssignment@getFloorInfo',
        data: {
            dorm: building,
            floor: floor,
        }
    }, floorOverviewCallback)
}

// retrieves the student info for a given room location
function getOccupantInfo(location) {
    return getData({
        route: 'Student@getOccupancyInfo',
        data: {
            location: location,
        }
    }, occupantCallback)
}
//replaces the previous floor information with the given building and floor.
function swapFloorView(building,floor_number=1) {
    let container = $('.floor_info');
    let height = container.height();
    // only get new info if any floor but the current floor is selected
    if (!$(this).hasClass('active')) {
        $('.floor_select.active').removeClass('active');
        $(this).addClass('active');
        // set the height of the container and fade out. Hide the dirty work
        container.css('height',`${height}px`).fadeOut(function () {
            $.when(container.children().detach()).done(function () {
                // get the info for the new floor
                getFloorInfo(building, floor_number);
                container.fadeIn();
            });
        });
    }
}

function getAvailableRooms(){
    return getData({
        route: 'Dormitory@getAvailableRooms',
    }, getAvailableRoomsCallback)
}
/* ******************* event related functions ******************* */

// changes out the floor information
$('body').on('click', '.floor_select', function () {
    let floor_number = $(this).text();
    let building = $('.building_select.active')
        .attr('id')
        .replace('building_', '');
        swapFloorView(building,floor_number);
})
    // building selection menu
    .on('click','.building_select', function(){
        $('.building_select').removeClass('active');
        let building = $(this).attr('id').replace('building_', '');
        $(this).addClass('active');

        swapFloorView(building,1);

});

// populate the door room modal with student information when it's activated.
$('#dorm_room_modal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget);
    // get the location info from the button
    let location = button.data('location').split('_');
    getOccupantInfo(location);
});

$('#add_student_modal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget);
    let location = null;
    if (button.hasClass('from_modal')){
        location = button.data('location').split(',');
    }else {
        getAvailableRooms();
    }
});
/* ******************* callback functions ******************* */

// takes the data from the server, builds and inserts the HTML
function buildMenuItemsCallback(data) {
    let template = getTemplate('menu_item');
    for (let key in data) {
        let menu_item = populateTemplate(template, data[key]);
        $('.building_menu').append(menu_item);
        if (key == 0) {
            // get the building info for the first building
            // and start building the floor info
            floorView(data[key]);
        }
    }
}
// builds and inserts the student info HTML into the door room modal
function occupantCallback(data) {
    let template = getTemplate('occupant_list_item');
    $('.occupants_list').children().detach();
    if (Array.isArray(data)) {
        for (let key in data) {
            roomModalData(template, data[key])
        }
    } else {
        roomModalData(template, data)
    }
}

//builds and inserts the floor information into the overview panel
function floorOverviewCallback(data) {
    let template = getTemplate('unit');
    let building = $('.building_select.active').attr('id').replace('building_', '');
    let attributes = {
        building_id: building,
    };
    //iterate through each unit and build the attributes for insertion into the template
    for (let unit in data) {
        attributes['unit'] = unit;
        attributes['gender_icon'] = setIcons({
            icon_name: data[unit].gender.toLowerCase() + ' fa-2x',
            quantity: 1,
        });
        attributes['gender_class'] = data[unit].gender.toLowerCase();
        // iterate through the rooms in each unit to add the occupancy icons.
        for (let room in data[unit]) {
            if (room !== 'gender') {
                attributes[`room_${room}`] = (data[unit][room] < 1) ? '' : setIcons({
                    icon_name: 'user',
                    quantity: data[unit][room],
                });
            }
        }
        let card = populateTemplate(template, attributes);
        $('.floor_info').append(card);
        $(`#unit_${building}_${unit}`).fadeIn();
    }
}
function getAvailableRoomsCallback(data) {
    console.log(data);

}

/* ******************* template related functions ******************* */

// pulls the html from the template container
function getTemplate(template_id) {
    return $(`#${template_id}`).html()
}

// iterates through the data and inserts it into the template
function populateTemplate(template, data) {
    for (let key in data) {
        let regex = new RegExp('{{' + key + '}}', 'g');
        template = template.replace(regex, data[key]);
    }
    return template;
}

/* ******************* other functions ******************* */

// AJAX handler
function getData(data, callback) {
    return $.ajax({
        method: "POST",
        url: "ajax/",
        data: data,
    }).done(callback);
}

// populates the dorm room modal with student info or availability info
function roomModalData(template, data = null) {
    let icon = setIcons({icon_name: 'user'});
    data['phone'] = formatPhoneNumber(data);
    // if there is space available add a different icon
    if (data['first_name'] === "Available") {
        icon = setIcons({icon_name: 'user-plus'})
    }
    data['first_name'] = icon + data['first_name'];
    let item = populateTemplate(template, data);
    $('.occupants_list').append(item)
}

// builds fontAwesome icon HTML
function setIcons(options) {
    let icon = `<i class='fas fa-${options.icon_name} fa-fw'></i>`;
    if (options.quantity) {
        icon = icon.repeat(options.quantity);
    }
    return icon;
}
// formats phone number for display
function formatPhoneNumber(data) {
    let phoneNumberString = data['phone'];
    // returns the add student button if the space is available.
    if (phoneNumberString.includes('click')) {
        return '<button data-location="'+data['location']+'" class="from_modal btn btn-success btn-sm" data-toggle="modal" data-target="#add_student_modal">'
            + setIcons({icon_name: 'user-plus'})
            + phoneNumberString
            + '</button>';
    }
    let cleaned = ('' + phoneNumberString).replace(/\D/g, '');
    // Blatantly took this from Stack Overflow.
    let match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
    if (match) {
        return setIcons({icon_name: 'phone'}) + '(' + match[1] + ') ' + match[2] + '-' + match[3];
    }
    return null;
}