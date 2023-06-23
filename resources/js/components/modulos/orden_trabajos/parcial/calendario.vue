<template>
    <div class="row full-calendar-container">
        <div class="col-md-12">
            <FullCalendar
                ref="calendar"
                :options="calendarOptions"
                style="width: 100%;min-height: 500px;"
                v-show="muestra_calendario"
            />
        </div>
    </div>
</template>
<script>
import FullCalendar from "@fullcalendar/vue";
import dayGridPlugin from "@fullcalendar/daygrid";
import interactionPlugin from "@fullcalendar/interaction";
import esLocale from "@fullcalendar/core/locales/es";

export default {
    props: ["anio_mes"],
    components: {
        FullCalendar, // make the <FullCalendar> tag available
    },
    watch: {
        anio_mes(newVal) {
            this.muestra_calendario = false;
            if (newVal.length > 1) {
                if (newVal[0] && newVal[1]) {
                    let nueva_fecha = `${newVal[0]}-${newVal[1]}-01`;
                    const calendar = this.$refs.calendar.getApi();
                    this.calendarOptions.initialDate = this.getFeachaActual();
                    setTimeout(() => {
                        calendar.gotoDate(nueva_fecha);
                    }, 300);
                    this.fecha_actual = nueva_fecha;
                    this.muestra_calendario = true;
                }
            }
        },
    },
    data() {
        return {
            fecha_actual: "",
            muestra_calendario: false,
            calendarOptions: {
                plugins: [dayGridPlugin, interactionPlugin],
                initialView: "dayGridMonth",
                weekends: false,
                events: [{ title: "Meeting", start: new Date() }],
                initialDate: null, // Set the default start date of the calendar (YYYY-MM-DD)
                editable: true, // Enable event dragging and resizing
                eventDrop: this.eventDrop,
                locale: esLocale,
                headerToolbar: {
                    start: "", // Dejar en blanco para ocultar los botones de navegación
                    center: "title",
                    end: "", // Dejar en blanco para ocultar el botón "Hoy"
                },
                customButtons: {
                    todayButton: {
                        text: "Hoy",
                        click: function () {
                            // Acción personalizada para el botón "Hoy" (opcional)
                        },
                    },
                },
            },
        };
    },
    mounted() {},
    methods: {
        eventDrop(info) {
            // Event handler for when an event is dropped
            console.log("Event dropped:", info.event.title);
            console.log("New start date:", info.event.start);
        },
    },
};
</script>
<style></style>
