$(document).ready(function () {
    // Intercept form submission
    $('#addForm').on('submit', function (e) {
        e.preventDefault(); // Prevent the default form submission

        const formData = new FormData(this);

        // Send form data via AJAX
        $.ajax({
            url: 'add.php', // Target PHP file for processing
            datatype: 'json',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                // If there's an error message in the response, show the modal
                if (response.error) {
                    $('#errorMessage').text(response.error);
                    $('#errorModal').modal('show');
                } else if (!response.missing) {
                    $('#successMessage').text(response.success);
                    $('#successAddModal').modal('show');
                }
            },
            error: function () {
                alert('Something went wrong while sending adding user request')
            }
        });
    });
});