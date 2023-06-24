<template>
    <div class="row full-calendar-container">
        <div class="col-md-12">
            <FullCalendar
                ref="calendar"
                :options="calendarOptions"
                style="width: 100%; min-height: 500px"
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
                    this.anio = newVal[0];
                    this.mes = newVal[1];
                    this.getOrdenTrabajosAnioMes();
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
    computed: {
        calendarOptions() {
            return {
                plugins: [dayGridPlugin, interactionPlugin],
                initialView: "dayGridMonth",
                weekends: true,
                events: this.listRegistros,
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
                eventContent: this.customizeEventContent,
                eventAllow: this.eventAllow,
            };
        },
    },
    data() {
        return {
            fecha_actual: "",
            muestra_calendario: false,
            anio: this.anio_mes[0],
            mes: this.anio_mes[1],
            listRegistros: [],
        };
    },
    mounted() {},
    methods: {
        getOrdenTrabajosAnioMes() {
            axios
                .get("/admin/orden_trabajos/getByAnioMes", {
                    params: {
                        anio: this.anio,
                        mes: this.mes,
                    },
                })
                .then((response) => {
                    const registros = response.data.registros;
                    this.listRegistros = registros.map((registro) => {
                        return {
                            id: registro.id, // Título del evento
                            title: registro.id, // Título del evento
                            start: registro.fecha_programada, // Fecha de inicio del evento
                            descripcion: registro.gama.descripcion,
                            estado: registro.estado,
                            prioridad: registro.prioridad,
                            backgroundColor:
                                registro.estado == "PROGRAMADO"
                                    ? "#3788d8"
                                    : "#1f2d3d",
                            isDraggable:
                                registro.estado == "PROGRAMADO" ? true : false,
                        };
                    });

                    const calendar = this.$refs.calendar.getApi();
                    calendar.removeAllEvents(); // Elimina los eventos actuales
                    calendar.addEventSource(this.listRegistros); // Agrega los nuevos eventos
                });
        },
        eventDrop(info) {
            // Event handler for when an event is dropped
            console.log("Event dropped:", info.event.title);
            console.log("New start date:", info.event.start);
        },
        eventAllow(dropInfo, draggedEvent) {
            const estado = draggedEvent.extendedProps.estado;
            // Permitir arrastrar si el estado es "PROGRAMADO", de lo contrario, no permitirlo
            return estado === "PROGRAMADO";
        },
        customizeEventContent(eventInfo) {
            const eventTitle = document.createElement("div");
            eventTitle.classList.add("event-title");
            eventTitle.innerText = "OT: " + eventInfo.event.title;

            const eventDescription = document.createElement("div");
            eventDescription.classList.add("event-description");
            eventDescription.innerText =
                eventInfo.event.extendedProps.descripcion;
            const eventEstado = document.createElement("div");
            eventEstado.classList.add("event-estado");
            eventEstado.innerText = eventInfo.event.extendedProps.estado;

            const eventContent = document.createElement("div");
            eventContent.appendChild(eventTitle);
            eventContent.appendChild(eventDescription);
            // eventContent.appendChild(eventEstado);

            return { domNodes: [eventContent] };
        },
    },
};
</script>
<style>
.full-calendar-container .fc-toolbar-title {
    text-transform: uppercase;
}
</style>
