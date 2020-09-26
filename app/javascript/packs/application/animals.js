document.addEventListener("turbolinks:load", function () {
  // New and Edit
  const adoptionStatus = document.querySelector("#animal_adoption_status")
  const adopterNameWrap = document.querySelector("#animal_adopter_name_wrap")
  const adopterName = document.querySelector("#animal_adopter_name")

  if (adopterNameWrap != undefined) {
    adopterNameWrap.classList.add("hide_animal_adopter_name_wrap")
  }

  if (adoptionStatus != undefined) {
    adoptionStatus.onchange = function () {
      const value = this.value

      if (value == "true") {
        adopterNameWrap.classList.remove("hide_animal_adopter_name_wrap")
        adopterNameWrap.classList.add("show_animal_adopter_name_wrap")
      } else {
        adopterName.value = ""
        adopterNameWrap.classList.remove("show_animal_adopter_name_wrap")
        adopterNameWrap.classList.add("hide_animal_adopter_name_wrap")
      }
    }
  }

  // Sort
  let animalSortForm = document.querySelector("#animal_sort_form")
  let animalSort = document.querySelector("#animal_sort")

  if (animalSort != undefined) {
    animalSort.onchange = function () {
      animalSortForm.submit()
    }
  }

  // Masker
  let animalDateOfBirth = document.querySelector("#animal_date_of_birth")
  if (animalDateOfBirth != undefined) {
    VMasker(animalDateOfBirth).maskPattern("99/99/9999")
  }
})
