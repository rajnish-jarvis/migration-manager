document.addEventListener("DOMContentLoaded", function() {
  const operationSelect = document.getElementById("operation_type");
  const tableNameField = document.getElementById("table_name_field");

  function toggleTableNameVisibility() {
    if (operationSelect.value === "Create Table") {
      tableNameField.style.display = "none";
    } else {
      tableNameField.style.display = "block";
    }
  }

  operationSelect.addEventListener("change", toggleTableNameVisibility);
  toggleTableNameVisibility(); // Initial check on page load
});