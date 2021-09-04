subtypeLookup = {};

$().ready(
    addHandlers();
);

function addHandlers () {

    calculateSubtypeLookup();

    // expansions/abbreviations
    document.getElementById('expansions').addEventListener('change', function (e) {
        let value, elems;
        value = e.target.value;
        if (value === 'am') {
            elems = document.getElementsByClassName('am');
            for (let i=0; i<elems.length; i+=1) {
                elems[i].style.display = 'inline';
            }
            elems = document.getElementsByClassName('ex');
            for (let i=0; i<elems.length; i+=1) {
                elems[i].style.display = 'none';
            }
        } else {
            elems = document.getElementsByClassName('ex');
            for (let i=0; i<elems.length; i+=1) {
                elems[i].style.display = 'inline';
            }
            elems = document.getElementsByClassName('am');
            for (let i=0; i<elems.length; i+=1) {
                elems[i].style.display = 'none';
            }
        }
    });

    document.getElementById('type').addEventListener('change', function (e) {
      let value, html;
      value = e.target.value;
      if (subtypeLookup.hasOwnProperty(value)) {
        html = ['<option value="none">select</option>'];
        for (let i=0; i<subtypeLookup[value].length; i+=1) {
          html.push('<option value="' + subtypeLookup[value][i] + '">' + subtypeLookup[value][i] + '</option>');
        }
        document.getElementById('subtype').innerHTML = html.join('');
      } else {
        document.getElementById('subtype').innerHTML = '<option value="none">select</option>';
      }
      highlightType(value);
    });

    document.getElementById('subtype').addEventListener('change', function (e) {
      let value;
      value = e.target.value;
      highlightSubtype(value);
    });


};

function calculateSubtypeLookup() {
  let subtype, subtypeList, details;
  subtypes = document.getElementById('subtype-values').value;
  subtypeList = subtypes.split('|');
  for (let i=0; i<subtypeList.length; i+=1) {
    details = subtypeList[i].split('-');
    if (!subtypeLookup.hasOwnProperty(details[0])) {
      subtypeLookup[details[0]] = [];
    }
    subtypeLookup[details[0]].push(details[1]);
  }
};

function highlightType(type) {
  $('.highlighted-subtype').removeClass('highlighted-subtype');
  $('.highlighted-type').removeClass('highlighted-type');
  $('.' + type).addClass('highlighted-type');
};

function highlightSubtype(subtype) {
  let subtypes, requiredSubtypes;
  $('.highlighted-subtype').removeClass('highlighted-subtype');
  subtypes = subtype.split(' ');
  requiredSubtypes = [];
  for (let i=0; i<subtypes.length; i+=1) {
    requiredSubtypes.push('.' + subtypes[i]);
  }
  $('.highlighted-type' + requiredSubtypes.join('')).addClass('highlighted-subtype');
};
