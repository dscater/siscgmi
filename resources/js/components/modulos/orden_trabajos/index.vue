<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Ordenes de trabajo</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row pl-1 pr-1">
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_trabajos.index')"
                            :to="{ name: 'orden_trabajos.programacion' }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Programación
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('orden_generadas.index')"
                            :to="{
                                name: 'orden_trabajos.generar_ots',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list"></i>
                            Generar OT
                        </router-link>
                    </div>
                    <div class="col-md-2 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('pedido_repuestos.index')"
                            :to="{
                                name: 'orden_trabajos.pedido_repuestos',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fas fa-tasks"></i>
                            Pedido de Repuestos
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <b-col lg="10" class="my-1">
                                        <b-form-group
                                            label="Buscar"
                                            label-for="filter-input"
                                            label-cols-sm="3"
                                            label-align-sm="right"
                                            label-size="sm"
                                            class="mb-0"
                                        >
                                            <b-input-group size="sm">
                                                <b-form-input
                                                    id="filter-input"
                                                    v-model="filter"
                                                    type="search"
                                                    placeholder="Buscar"
                                                ></b-form-input>

                                                <b-input-group-append>
                                                    <b-button
                                                        class="bg-primary"
                                                        variant="primary"
                                                        :disabled="!filter"
                                                        @click="filter = ''"
                                                        >Borrar</b-button
                                                    >
                                                </b-input-group-append>
                                            </b-input-group>
                                        </b-form-group>
                                    </b-col>
                                    <div class="col-md-12">
                                        <b-overlay
                                            :show="showOverlay"
                                            rounded="sm"
                                        >
                                            <b-table
                                                :fields="fields"
                                                :items="listRegistros"
                                                show-empty
                                                stacked="md"
                                                responsive
                                                :current-page="currentPage"
                                                :per-page="perPage"
                                                @filtered="onFiltered"
                                                empty-text="Sin resultados"
                                                empty-filtered-text="Sin resultados"
                                                :filter="filter"
                                            >
                                                <template
                                                    #cell(fecha_registro)="row"
                                                >
                                                    {{
                                                        formatoFecha(
                                                            row.item
                                                                .fecha_registro
                                                        )
                                                    }}
                                                </template>

                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-primary"
                                                            class="btn-flat btn-block"
                                                            title="Visualizar registro"
                                                            @click="
                                                                visualizarOrdenTrabajo(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-eye"
                                                            ></i>
                                                        </b-button>
                                                    </div>
                                                </template>
                                            </b-table>
                                        </b-overlay>
                                        <div class="row">
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="ml-auto my-1"
                                            >
                                                <b-form-select
                                                    align="right"
                                                    id="per-page-select"
                                                    v-model="perPage"
                                                    :options="pageOptions"
                                                    size="sm"
                                                ></b-form-select>
                                            </b-col>
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="my-1 mr-auto"
                                                v-if="perPage"
                                            >
                                                <b-pagination
                                                    v-model="currentPage"
                                                    :total-rows="totalRows"
                                                    :per-page="perPage"
                                                    align="left"
                                                ></b-pagination>
                                            </b-col>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <Nuevo
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :orden_trabajo="oOrdenTrabajo"
            @close="muestra_modal = false"
            @envioModal="getOrdenTrabajos"
        ></Nuevo>
    </div>
</template>

<script>
import Nuevo from "./Nuevo.vue";
export default {
    components: {
        Nuevo,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            search: "",
            listRegistros: [],
            showOverlay: false,
            fields: [
                { key: "id", label: "Código", sortable: true },
                {
                    key: "fecha_programada",
                    label: "Fecha Programada",
                    sortable: true,
                },
                {
                    key: "subunidad.full_name",
                    label: "Subunidad",
                    sortable: true,
                },
                {
                    key: "gama.full_name",
                    label: "Gama de mantenimiento",
                    sortable: true,
                },
                { key: "prioridad", label: "Prioridad", sortable: true },
                { key: "tiempo", label: "Tiempo total", sortable: true },
                {
                    key: "dias",
                    label: "Días estimados para terminar",
                    sortable: true,
                },
                {
                    key: "tipo_mantenimiento",
                    label: "Tipo de Mantenimiento",
                    sortable: true,
                },
                { key: "estado", label: "Estado", sortable: true },
                { key: "accion", label: "Acción" },
            ],
            loading: true,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            oOrdenTrabajo: {
                id: 0,
                fecha_programada: "",
                subunidad_id: "",
                gama_id: "",
                prioridad: "",
                tiempo: "",
                dias: "",
                tipo_mantenimiento: "",
                estado: "",
            },
            currentPage: 1,
            perPage: 5,
            pageOptions: [
                { value: 5, text: "Mostrar 5 Registros" },
                { value: 10, text: "Mostrar 10 Registros" },
                { value: 25, text: "Mostrar 25 Registros" },
                { value: 50, text: "Mostrar 50 Registros" },
                { value: 100, text: "Mostrar 100 Registros" },
                { value: this.totalRows, text: "Mostrar Todo" },
            ],
            totalRows: 10,
            filter: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getOrdenTrabajos();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        visualizarOrdenTrabajo(item) {
            this.$router.push({
                name: "orden_trabajos.show",
                params: { id: item.id },
            });
        },

        // Listar OrdenTrabajos
        getOrdenTrabajos() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = "/admin/orden_trabajos";
            if (this.pagina != 0) {
                url += "?page=" + this.pagina;
            }
            axios
                .get(url, {
                    params: { per_page: this.per_page },
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listRegistros = res.data.orden_trabajos;
                    this.totalRows = res.data.total;
                });
        },
        eliminaOrdenTrabajo(id, descripcion) {
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${descripcion}</strong>`,
                showCancelButton: true,
                confirmButtonColor: "#149FDA",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post("/admin/orden_trabajos/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getOrdenTrabajos();
                            this.filter = "";
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
                            if (error.response) {
                                if (error.response.status === 422) {
                                    this.errors = error.response.data.errors;
                                }
                                if (
                                    error.response.status === 420 ||
                                    error.response.status === 419 ||
                                    error.response.status === 401
                                ) {
                                    window.location = "/";
                                }
                                if (error.response.status === 500) {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Error",
                                        html: error.response.data.message,
                                        showConfirmButton: false,
                                        timer: 2000,
                                    });
                                }
                            }
                        });
                }
            });
        },
        abreModal(tipo_accion = "nuevo", orden_trabajo = null) {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
            if (orden_trabajo) {
                this.oOrdenTrabajo = orden_trabajo;
            }
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        limpiaOrdenTrabajo() {
            this.oOrdenTrabajo.fecha_programada = "";
            this.oOrdenTrabajo.subunidad_id = "";
            this.oOrdenTrabajo.gama_id = "";
            this.oOrdenTrabajo.prioridad = "";
            this.oOrdenTrabajo.tiempo = "";
            this.oOrdenTrabajo.dias = "";
            this.oOrdenTrabajo.tipo_mantenimiento = "";
            this.oOrdenTrabajo.estado = "";
        },
        formatoFecha(date) {
            return this.$moment(String(date)).format("DD/MM/YYYY");
        },
    },
};
</script>

<style></style>
