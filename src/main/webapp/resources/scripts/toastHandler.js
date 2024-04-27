if (errorMessage !== "null" && errorMessage !== '') {
    window.toastr.error(errorMessage);
}

if (successMessage !== "null" && successMessage !== '') {
    window.toastr.success(successMessage);
}