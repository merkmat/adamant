--------------------------------------------------------------------------------
-- {{ formatType(model_name) }} {{ formatType(model_type) }} C/C++ Interface Spec
--
-- Generated from {{ filename }} on {{ time }}.
--------------------------------------------------------------------------------

-- Standard Includes:
with Ada.Unchecked_Conversion;
{% if type_includes %}

-- Record Component Includes:
{% for include in packed_type_includes %}
with {{ include }}.C;
{% endfor %}
{% endif %}

{% if description %}
{{ printMultiLine(description, '-- ') }}
{% endif %}
package {{ name }}.C is

   -- Unpacked C/C++ compatible type:
   type U_C is record
{% for field in fields.values() %}
{% if field.description %}
{{ printMultiLine(field.description, '      -- ') }}
{% endif %}
{% if field.is_packed_type %}
      {{ field.name }} : aliased {{ field.type_package }}.C.U_C{% if field.default_value %} := {{ field.default_value }}{% endif %};
{% else %}
      {{ field.name }} : aliased {{ field.type }}{% if field.default_value %} := {{ field.default_value }}{% endif %};
{% endif %}
{% endfor %}
   end record
      with Convention => C_Pass_By_Copy;

   -- Access type for U_C.
   type U_C_Access is access all U_C;

   -- Functions for converting between the Ada and C version of the packed type:
   function To_Ada is new Ada.Unchecked_Conversion (Source => U_C, Target => U);
   function To_C is new Ada.Unchecked_Conversion (Source => U, Target => U_C);

   -- The .C package is not supported for all Adamant packed records. We do not allow compilation in
   -- these cases.
   pragma Compile_Time_Error ({{ name }}.U'Size /= U_C'Size, "C type size not compatible with Ada type size.");

end {{ name }}.C;
