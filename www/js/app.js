$(function() {
    build_menu_items();
});

function build_menu_items() {
    get_data(
        {
            route: 'Dormitory@getAll',
        }
        ,menu_item_callback
    )
}
function get_template(template_id){
 return $(`#${template_id}`).html()
}
function populate_template(template,data){
    for(let key in data){
        let regex = new RegExp('{{'+key+'}}','g');
        template = template.replace(regex,data[key]);
    }
    return template;
}
function get_data(data,callback) {
     return $.ajax({
        method: "POST",
        url: "ajax/",
        data: data,
    }).done(callback);
}
function default_view(first_building) {
    //loads default info into the building window.
    $('.building_name').text(first_building.name)
    $(`#building_${first_building.id}`).first().addClass('active');
    get_floor_info(first_building.id);
}
function get_floor_info(building, floor= 1) {
    get_data({
        route: 'RoomAssignment@getFloorInfo',
        data: {
            dorm: building,
            floor: floor,
        }
    },floor_overview_callback)
}
function get_occupant_info(location) {
   return get_data({
        route: 'Student@getOccupancyInfo',
        data: {
            location: location,
        }
    },occupant_callback)
}
function occupant_callback(data){
    let template = get_template('occupant_list_item');
    $('.occupants_list').children().detach()
    console.log(data)
    if(Array.isArray(data)){
            for(let key in data){
                modal_data(template,data[key])
            }
    }else{
        modal_data(template,data)
    }
}

function modal_data(template,data=null){
    let icon = '<i class="fas fa-user fa-fw"></i> '
    data['phone'] = formatPhoneNumber(data['phone']);
    if(data['first_name'] === "Available"){
        icon = '<i class="fas fa-user-plus fa-fw"></i> '
    }
    data['first_name'] = icon + data['first_name'];
    let item = populate_template(template,data);
    $('.occupants_list').append(item)

}
function set_icons(options){
let icon = `<i class='fas fa-${options.icon_name}'></i>`
    if(options.quantity){
        icon = icon.repeat(options.quantity);
    }
    return icon;
}
function floor_overview_callback(data) {
    console.log(data)
    let template = get_template('unit');
    let building = $('.building_select.active').attr('id').replace('building_','');
    let attributes = {
        building_id: building,
    };
    for (let unit in data) {
        attributes['unit'] = unit;
        attributes['gender_icon'] = set_icons({
            icon_name: data[unit].gender.toLowerCase()+' fa-2x',
            quantity: 1,
        });
        attributes['gender_class'] = data[unit].gender.toLowerCase();
        for(let key in data[unit]){
            if(key !== 'gender'){
                attributes[`room_${key}`] = (data[unit][key] < 1)? '': set_icons({
                    icon_name: 'user',
                    quantity: data[unit][key],
                });
            }
        }
        let card = populate_template(template,attributes);
        $('.floor_info').append(card);
        $(`#unit_${building}_${unit}`).fadeIn();
    }
};
function menu_item_callback(data) {
    let template = get_template('menu_item');
    for(let key in data){
        let menu_item = populate_template(template,data[key]);
        $('.building_menu').append(menu_item);
        if (key == 0){
            default_view(data[key]);
        }
    }
};

$('body').on('click','.floor_select',function() {
    let floor_number = $(this).text();
    let building = $('.building_select.active').attr('id').replace('building_','');
    let container = $('.floor_info');
    let height =  $('.floor_info').height();
    if(!$(this).hasClass('active')){
        $('.floor_select.active').removeClass('active')
        $(this).addClass('active');
        $.when(container.css('height',height+'px').children().fadeOut(function () {
            container.children().detach();
        })).done(function(){
                get_floor_info(building,floor_number);
            container.children().fadeIn();

        })
    }
})
$('#dorm_room_modal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget)
    let location = button.data('location').split('_');
    let students = get_occupant_info(location);
})

// Blatantly took this from Stack Overflow.
function formatPhoneNumber(phoneNumberString) {
    if(phoneNumberString.includes('click')){
        return phoneNumberString;
    }
    var cleaned = ('' + phoneNumberString).replace(/\D/g, '')
    var match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/)
    if (match) {
        return '<i class="fas fa-phone fa-fw"></i> '+'(' + match[1] + ') ' + match[2] + '-' + match[3]
    }
    return null
}