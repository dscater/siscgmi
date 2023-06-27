<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Pedido de Repuestos</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <button
                                            v-if="
                                                permisos.includes(
                                                    'pedido_repuestos.create'
                                                )
                                            "
                                            class="btn btn-primary btn-flat btn-block border-white"
                                            @click="
                                                abreModal('nuevo');
                                                limpiaPedidoRepuesto();
                                            "
                                        >
                                            <i class="fa fa-plus"></i>
                                            Nuevo
                                        </button>
                                    </div>
                                </div>
                            </div>
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
                                                <template #cell(detalles)="row">
                                                    <b-button
                                                        size="sm"
                                                        variant="primary"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        {{
                                                            row.detailsShowing
                                                                ? "Ocultar"
                                                                : "Ver"
                                                        }}
                                                        Detalles
                                                    </b-button>
                                                </template>
                                                <template #row-details="row">
                                                    <b-card>
                                                        <h4 class="text-sm">
                                                            REPUESTOS
                                                            SOLICITADOS
                                                        </h4>
                                                        <table
                                                            class="table table-bordered"
                                                        >
                                                            <thead>
                                                                <tr>
                                                                    <th>#</th>
                                                                    <th>
                                                                        Repuesto
                                                                    </th>
                                                                    <th>
                                                                        Cantidad
                                                                        Requerida
                                                                    </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr
                                                                    v-for="(
                                                                        item,
                                                                        index
                                                                    ) in row
                                                                        .item
                                                                        .detalle_pedidos"
                                                                >
                                                                    <td>
                                                                        {{
                                                                            index +
                                                                            1
                                                                        }}
                                                                    </td>
                                                                    <td>
                                                                        {{
                                                                            item
                                                                                .repuesto
                                                                                .full_name
                                                                        }}
                                                                    </td>
                                                                    <td>
                                                                        {{
                                                                            item.cantidad_requerida
                                                                        }}
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </b-card>
                                                    <b-button
                                                        size="sm"
                                                        variant="primary"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        Ocultar Detalles
                                                    </b-button>
                                                    <b-button
                                                        size="sm"
                                                        pill
                                                        variant="outline-warning"
                                                        class="btn-flat"
                                                        title="Editar registro"
                                                        @click="
                                                            editarRegistro(
                                                                row.item
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-edit"
                                                        ></i>
                                                    </b-button>
                                                    <b-button
                                                        size="sm"
                                                        pill
                                                        variant="outline-danger"
                                                        class="btn-flat"
                                                        title="Eliminar registro"
                                                        @click="
                                                            eliminaPedidoRepuesto(
                                                                row.item.id,
                                                                row.item.id +
                                                                    ' |' +
                                                                    row.item
                                                                        .orden_trabajo
                                                                        .id
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-trash"
                                                        ></i>
                                                    </b-button>
                                                </template>

                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-warning"
                                                            class="btn-flat btn-block"
                                                            title="Editar registro"
                                                            @click="
                                                                editarRegistro(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-edit"
                                                            ></i>
                                                        </b-button>
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-danger"
                                                            class="btn-flat btn-block"
                                                            title="Eliminar registro"
                                                            @click="
                                                                eliminaPedidoRepuesto(
                                                                    row.item.id,
                                                                    row.item
                                                                        .id +
                                                                        ' | ' +
                                                                        row.item
                                                                            .orden_trabajo
                                                                            .id
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
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
        <PedidoRepuesto
            :muestra_modal="muestra_modal"
            :accion="modal_accion"
            :pedido_repuesto="oPedidoRepuesto"
            @close="muestra_modal = false"
            @envioModal="getPedidoRepuestos"
        ></PedidoRepuesto>
    </div>
</template>

<script>
import PedidoRepuesto from "./PedidoRepuesto.vue";
export default {
    components: {
        PedidoRepuesto,
    },
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            search: "",
            listRegistros: [],
            showOverlay: false,
            fields: [
                { key: "id", label: "Código", sortable: true },
                {
                    key: "orden_trabajo.id",
                    label: "Nro. Orden de Trabajo",
                    sortable: true,
                },
                { key: "detalles", label: "Detalles", sortable: true },
                { key: "accion", label: "Acción" },
            ],
            muestra_modal: false,
            modal_accion: "nuevo",
            loading: true,
            oPedidoRepuesto: {
                id: 0,
                orden_id: 0,
                orden_trabajo: {
                    fecha_programada: "",
                    subunidad_id: "",
                    gama_id: "",
                    prioridad: "",
                    tiempo: "",
                    dias: "",
                    tipo_mantenimiento: "",
                    estado: "",
                    orden_generada: {
                        id: 0,
                        archivo: "",
                        descripcion_documentacion: "",
                        comentario: "",
                        detalle_repuestos: [],
                        detalle_herramientas: [],
                        detalle_personals: [],
                    },
                },
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
        this.getPedidoRepuestos();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.oPedidoRepuesto = item;
            this.oPedidoRepuesto.id = item.id;
            this.oPedidoRepuesto.orden_trabajo = item.orden_trabajo
                ? item.orden_trabajo
                : "";
            this.modal_accion = "edit";
            this.muestra_modal = true;
        },

        // Listar pedido repuestos
        getPedidoRepuestos() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = "/admin/pedido_repuestos";
            if (this.pagina != 0) {
                url += "?page=" + this.pagina;
            }
            axios
                .get(url, {
                    params: { per_page: this.per_page },
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listRegistros = res.data.pedido_repuestos;
                    this.totalRows = res.data.total;
                });
        },
        eliminaPedidoRepuesto(id, descripcion) {
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
                        .post("/admin/pedido_repuestos/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getPedidoRepuestos();
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
        abreModal(tipo_accion = "nuevo") {
            this.muestra_modal = true;
            this.modal_accion = tipo_accion;
            this.oPedidoRepuesto = {
                id: 0,
                orden_id: 0,
                orden_trabajo: {
                    fecha_programada: "",
                    subunidad_id: "",
                    gama_id: "",
                    prioridad: "",
                    tiempo: "",
                    dias: "",
                    tipo_mantenimiento: "",
                    estado: "",
                    orden_generada: {
                        id: 0,
                        archivo: "",
                        descripcion_documentacion: "",
                        comentario: "",
                        detalle_repuestos: [],
                        detalle_herramientas: [],
                        detalle_personals: [],
                    },
                },
            };
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        limpiaPedidoRepuesto() {
            this.oPedidoRepuesto.orden_id = "";
        },
    },
};
</script>

<style></style>
